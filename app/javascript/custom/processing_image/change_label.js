$(document).on('turbolinks:load', () => {

  $('#mark-as-negative').on('click', (event) => {
    let cell_id = $('#nucleus-id').text();
    $.ajax({
      url: `/scanned_cells/${cell_id}/change_label?label=negative`,
      method: 'patch',
      success: (response) => {
        $('#mark-as-negative').fadeToggle();
        $('#mark-as-positive').fadeToggle();
        $(`#cell-${cell_id}`).removeClass('border-success');
        $(`#cell-${cell_id}`).addClass('border-danger');
        $(`#cell-${cell_id}`).children().first().attr('data_label', 'negative')
      },
      error: (error) => {
        console.log(error);
      }
    })
  })

  $('#mark-as-positive').on('click', (event) => {
    let cell_id = $('#nucleus-id').text();
    $.ajax({
      url: `/scanned_cells/${cell_id}/change_label?label=positive`,
      method: 'patch',
      success: (response) => {
        $('#mark-as-negative').fadeToggle();
        $('#mark-as-positive').fadeToggle();
        $(`#cell-${cell_id}`).removeClass('border-danger');
        $(`#cell-${cell_id}`).addClass('border-success');
        $(`#cell-${cell_id}`).children().first().attr('data_label', 'positive')
      },
      error: (error) => {
        console.log(error);
      }
    })
  })

})
