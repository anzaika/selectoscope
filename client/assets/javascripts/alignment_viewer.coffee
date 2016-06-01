window.AlignmentViewer =
  seqs : {}
  lineHeight: 15
  labelsWidth: 230

  firstSequenceId: ->
    Object.keys(@seqs)[0]

  seqsCount: ->
    @seqs[@firstSequenceId()].length

  alignmentWidth: ->
    # $('#alignments').width() - @labelsWidth - 30

  alignmentHeight: ->
    @lineHeight * @seqsCount()

  build : (id, root, type='alignments')->
    AlignmentViewer.loadSeqs(id, type)
    setTimeout(->
      AlignmentViewer.drawAlignment(root, id)
    , 500)

  loadSeqs : (id, type) ->
    @seqs[id] = []
    $.getJSON "/#{type}/" + id + '.json',  (data) ->
      $.each data.sequences, (i, v) ->
        AlignmentViewer.seqs[id].push v

  drawAlignment : (root, id) ->
    opts = {
      seqs : AlignmentViewer.seqs[id]
      scheme : AlignmentViewer.colorscheme
      conf: AlignmentViewer.conf
      vis : AlignmentViewer.vis
      zoomer : AlignmentViewer.zoomer()
    }
    rootDiv = document.getElementById(root)
    m = msa(opts)
    rootDiv.appendChild(m.el)
    m.render()

  vis: {
    sequences: true
    markers: true
    metacell: false
    conserv: false
    overviewbox: false
    seqlogo: false
    gapHeader: false
    leftHeader: true

    labels: true
    labelName: true
    labelId: false
    labelPartition: false
    labelCheckbox: false

    metaGaps: false
    metaIdentity: false
    metaLinks: false
  }

  colorscheme: {
    scheme: "taylor"
    colorBackground: true
    showLowerCase: true
    opacity: 0.6
  }

  zoomer: ->
    {
      alignmentWidth: @alignmentWidth()
      alignmentHeight: @alignmentHeight()

      columnWidth: 15
      rowHeight: 15
      autoResize: true

      textVisible: true
      labelIdLength: 30
      labelNameLength: @labelsWidth
      labelPartLength: 15
      labelCheckLength: 15
      labelFontsize: 13
      labelLineHeight: "13px"

      markerFontsize: "10px"
      stepSize: 1
      markerStepSize: 2
      markerHeight: 20

      residueFont: "13"
      canvasEventScale: 1

      boxRectHeight: 2
      boxRectWidth: 2
      overviewboxPaddingTop: 10

      menuFontsize: "14px"
      menuItemFontsize: "14px"
      menuItemLineHeight: "14px"
      menuMarginLeft: "3px"
      menuPadding: "3px 4px 3px 4px"

      metaGapWidth: 35
      metaIdentWidth: 40
      metaLinksWidth: 25
    }
