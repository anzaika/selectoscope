require 'tntvis'

window.TreeBuilder =
  build : (newick, root, width) ->
    tree_vis = tnt.tree()
    theme = TreeBuilder.tnt_theme(newick, width)
    theme(tree_vis, document.getElementById(root))

  onClick : (node) ->
    obj = {}
    obj.header = 'Name: ' + node.node_name()
    obj.rows = []
    obj.rows.push
      label: 'Length'
      value: node.branch_length()
    tnt.tooltip.table().width(180).call(@)

  colorFunc : (source, target) ->
    n = Math.round(target.data().branch_length * 10000 / 255)
    color = 'hsl(' + n + ',80%,50%)'
    switch target.data().name
      when '-'
        color = 'green'
      else
        color = 'grey'
    color

  tnt_theme : (newick, width) ->
    theme = (tree_vis, root) ->
      tree_vis
        .data(tnt.tree.parse_newick(newick))
        .layout(
          tnt.tree
          .layout
          .vertical()
          .width(width)
          .scale(false))
        .branch_color(TreeBuilder.colorFunc)
        .label(tnt.tree.label.text().height(22))

      tree_vis.on('click', TreeBuilder.onClick)
      tree_vis(root)
