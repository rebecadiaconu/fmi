# Tema 1 Tehnici de Compilare, Diaconu Rebeca-Mihaela, Grupa 333
# Problema 3
'''
    Sa se scrie un program care primeste la intrare elementele unei expresii regulate (alfabetul
    expresiei, expresia propriu -zisa (in forma prefixata sau infixata - adica forma naturala), care contine 3
    tipuri de operatori: reuniune, concatenare si iteratie Kleene (*)). Sa se determine un automat finit
    nedeterminist cu lambda-tranzitii (sa se afiseze elementele sale) care recunoaste acelasi limbaj ca cel
    descris de expresia regulata. Programul afiseaza si graful care corespunde noului automat (grafic 1
    punct).

    Operatori:
    reuniune -> |
    concatenare -> .
    iteratie kleene -> *
'''
import pydot


class State:
    def __init__(self, value = "q0", transitions = None):
        self.value = value
        self.transitions = transitions

    def add_empty_transition(self, x):
        self.transitions.append((x, epsilon))

    def add_transition(self, x, symbol):
        self.transitions.append((x, symbol))


class Tree:
    def __init__(self, start = None, end = None):
        self.start = start # nod de tip State
        self.end = end # nod de tip State


def get_transitions(start, viz, tree):
    viz[int(start.value[1:])] = 1

    for i in range(len(start.transitions)):
        tree.append((start.value, start.transitions[i][0].value, start.transitions[i][1]))

    for state in start.transitions:
        if viz[int(state[0].value[1:])] == 0:
            get_transitions(state[0], viz, tree)


def is_operator(c):
    if c == "." or c == "|" or c == "*" or c == "(" or c == ")":
        return True
    else:
        return False


def convert_to_infix(expr):
    new_expr = []
    i = len(expr) - 1

    while i >= 0:

        if expr[i] == '*':
            str = new_expr.pop() + expr[i]
            new_expr.append(str)
            i -= 1
        elif not is_operator(expr[i]):
            new_expr.append(expr[i])
            i -= 1
        else:
            str = "(" + new_expr.pop() + expr[i] + new_expr.pop() + ")"
            new_expr.append(str)
            i -= 1

    return new_expr.pop()


def convert_to_postfix(expr):
    new_expr = []
    output = ''

    for i in range(len(expr)):
        if not is_operator(expr[i]):
            output += expr[i]
        elif expr[i] == "*":
            output += expr[i]
        elif expr[i] == "(":
            new_expr.append(expr[i])
        elif expr[i] == ")":
            while new_expr and new_expr[-1] != '(':
                output += new_expr.pop()

            new_expr.pop()
        else:
            new_expr.append(expr[i])

    while new_expr:
        output += new_expr.pop()

    return output


def build_tree(alphabet, expr):
    i = 0
    tree_nodes = []

    while i <= len(expr) - 1:
        if expr[i] in alphabet:
            tree = add_single(expr[i])
            tree_nodes.append(tree)

            i += 1
        elif expr[i] in ".|*":
            if expr[i] == ".":
                tree2 = tree_nodes.pop()
                tree1 = tree_nodes.pop()

                tree = add_concat(tree1, tree2)
                tree_nodes.append(tree)
            elif expr[i] == "|":
                tree2 = tree_nodes.pop()
                tree1 = tree_nodes.pop()

                tree = add_union(tree1, tree2)
                tree_nodes.append(tree)
            else:
                tree_kleene = tree_nodes.pop()
                tree = add_kleene(tree_kleene)
                tree_nodes.append(tree)

            i += 1

    return tree_nodes.pop()


def add_single(symbol):
    global current_number

    start = State("q" + str(current_number), [])
    current_number += 1

    end = State("q" + str(current_number), [])
    current_number += 1

    start.add_transition(end, symbol)

    return Tree(start, end)


def add_concat(first, second):
    first.end.transitions = second.start.transitions

    return Tree(first.start, second.end)


def add_union(first, second):
    global current_number

    start = State("q" + str(current_number), [])
    current_number += 1

    end = State("q" + str(current_number), [])
    current_number += 1

    start.add_empty_transition(first.start)
    start.add_empty_transition(second.start)
    first.end.add_empty_transition(end)
    second.end.add_empty_transition(end)

    return Tree(start, end)


def add_kleene(tree):
    global current_number

    start = State("q" + str(current_number), [])
    current_number += 1

    end = State("q" + str(current_number), [])
    current_number += 1

    tree.end.add_empty_transition(tree.start)
    tree.end.add_empty_transition(end)
    start.add_empty_transition(tree.start)
    start.add_empty_transition(end)

    return Tree(start, end)


def compute_regex(alphabet, expr):
    open_brackets, closed_brackets = 0, 0
    op_count = 0
    op_list = []

    if expr[0] in ".|*":
        expr = convert_to_infix(expr)[1:-1]

    for i in range(len(expr)):
        if expr[i] == "(":
            open_brackets += 1
            op_count = 0
            op_list = []

        elif expr[i] == ")":
            closed_brackets += 1
            op_count = 0
            op_list = []

        elif expr[i] in ".|*":
            op_count += 1
            op_list.append(expr[i])

            if op_count > 1 and op_list[0] != "*":
                raise ValueError("Expresie invalida! 2 operatori gasiti unul langa altul!")
        elif expr[i] not in alphabet and expr[i] not in ".|*":
            raise ValueError("Expresie invalida!")
        else:
            op_count = 0
            op_list = []

    if open_brackets != closed_brackets:
        raise ValueError("Numar de paranteze deschise-inchise inegal!")

    return convert_to_postfix(expression)


def compute_tree(viz, trans):
    tree = pydot.Dot('regex_lambda_nfa', graph_type='digraph',rankdir='LR',overlap=False,outputMode='edgesfirst',smoothType='graph_dist')

    for i in range(len(viz)):
        if viz[i] == 1:
            tree.add_node(pydot.Node("q" + str(i), shape='circle',color='lightgray', style='filled'))

    for i in range(len(trans)):
        tree.add_edge(pydot.Edge(trans[i][0], trans[i][1], label=trans[i][2], color='darkgreen'))

    tree.get_node(nfa_tree.start.value)[0].set_shape('doubleoctagon')
    tree.get_node(nfa_tree.end.value)[0].set_shape('doublecircle')

    tree.write('regex_lambda_nfa.dot')


epsilon = "E"
alphabet = "abcde"
expression = "((a|b.b)*.c)*"
current_number = 0

if expression == "":
    start = State("q0", [])
    end = State("q1", [])
    start.add_empty_transition(end)
    current_number = 2

    nfa_tree = Tree(start, end)
else:
    regex = compute_regex(alphabet, expression)
    nfa_tree = build_tree(alphabet, regex)

trans = []
viz = [0 for i in range(current_number)]
get_transitions(nfa_tree.start, viz, trans)

compute_tree(viz, trans)

