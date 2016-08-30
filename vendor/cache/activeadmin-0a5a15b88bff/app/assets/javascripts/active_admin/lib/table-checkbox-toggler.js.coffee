class ActiveAdmin.TableCheckboxToggler extends ActiveAdmin.CheckboxToggler
  _init: ->
    super

  _bind: ->
    super

    @$container.find('tbody td').click (e)=>
      @_didClickCell(e.target) if e.target.type isnt 'checkbox'

  _didChangeCheckbox: (checkbox) ->
    super

    $row = $(checkbox).parents 'tr'

    if checkbox.checked
      $row.addClass 'selected'
    else
      $row.removeClass 'selected'

  _didClickCell: (cell) ->
    $(cell).parent('tr').find(':checkbox').click()

$.widget.bridge 'tableCheckboxToggler', ActiveAdmin.TableCheckboxToggler
