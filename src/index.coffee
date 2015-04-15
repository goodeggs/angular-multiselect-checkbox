###
Checkbox for selecting/deselecting all rows in a table
  - when multiselect is clicked, it will add 'isSelected' to all rows

@param [Array] rows - rows that are selectable
@example
table.table(st-table='displayRows' st-safe-src='rows')
  thead
    tr
      th
        st-multiselect-checkbox(rows='displayRows')
  tbody
    tr(ng-repeat='row in displayRows')
      td
        input(ng-model='row.isSelected')

###

require 'angular-indeterminate-checkbox'

angular.module __filename, [
  'smart-table'
  'ngIndeterminateCheckbox'
]

.directive 'stMultiselectCheckbox', ->
  restrict: 'E'
  template: require './template'
  scope:
    rows: '='
  link: (scope, element, attrs) ->
    scope.checked = false

    getSelectedRows = ->
      scope.rows?.filter((row) -> row?.isSelected).length

    isSelectable = (row) ->
      return true unless row.isSelectable?
      row.isSelectable

    scope.$watch 'checked', (newValue, oldValue) ->
      return if newValue is oldValue
      row.isSelected = newValue for row in scope.rows when isSelectable(row)

    scope.$watch getSelectedRows, (count) ->
      debugger
      return if count is undefined
      if count is 0
        debugger
        scope.checked = false
        scope.indeterminate = false
      else if count is scope.rows?.filter(isSelectable).length
        debugger
        scope.checked = true
        scope.indeterminate = false
      else
        debugger
        scope.indeterminate = true

module.exports = __filename
