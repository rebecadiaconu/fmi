from binarytree import tree, Node


def buildTree(postorder, inorder):
    n = len(postorder)
    node = Node(postorder[n - 1])
    if n == 1:
        return node
    try:
        poz = inorder.index(postorder[n - 1])
    except:
        global ok
        ok = 1
        return
    if poz != 0:
        node.left = buildTree(postorder[:poz], inorder[:poz])
    if poz != n:
        node.right = buildTree(postorder[poz: n - 1], inorder[poz + 1: n])
    return node


ok = 0

postorder = [4, 1, 2, 3]
inorder = [1, 4, 3, 2]

start = buildTree(postorder, inorder)

if ok == 0:
    print(start.inorder)
    print(start.postorder)
    print(start.preorder)
else:
    print("Nu am putut crea un arbore. \n")