jQuery ->
  if $('#sortable').length > 0  
    $('#sortable').sortable(
      axis: 'y'
      items: '.offer'
      cursor: 'move'

      sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')
      stop: (e, ui) ->
        ui.item.removeClass('active-item-shadow')
        # highlight the row on drop to indicate an update
        ui.item.children('td').effect('highlight', {}, 1000)
      update: (e, ui) ->
        offer_id = ui.item.data('offer-id') 
        position = ui.item.index() # this will not work with paginated offers, as the index is zero on every page
        $.ajax(
          type: 'POST'
          url: '/backoffice/offers/' + offer_id + '/update_row_order'
          dataType: 'json'
          data: { id: offer_id, row_order: position }
        )
    )