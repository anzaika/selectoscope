engagePanelCollapser = ->
  $('.panel[data-panel]').each ->
    $this = $(this)
    $a = $('<a href=\'javascript:void(null)\'>').on('click', (event) ->
      $(this).closest('.panel').find('.panel_contents').each ->
        $(this).slideToggle()
        return
      $(this).closest('h3').each ->
        $(this).toggleClass 'panel-collapsed'
        return
      return
    )
    $h3 = $this.find('h3:first')
    $h3.each ->
      $(this).wrapInner $a
      return
    if $this.data('panel') is 'collapsed'
      $h3.each ->
        $(this).addClass 'panel-collapsed'
        return
      $this.find('.panel_contents').each ->
        $(this).hide()
        return
    return
  return

$(document).ready(engagePanelCollapser)
$(document).on('page:load', engagePanelCollapser)
