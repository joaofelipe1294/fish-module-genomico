$(document).on('turbolinks:load', () => {

  $('#mark-as-inappropriate').on('click', (event) => {
    let cell_id = $('#nucleus-id').text();
    $.ajax({
      url: `/scanned_cells/${cell_id}?label=inappropriate`,
      method: 'patch',
      success: (response) => {
        $('#mark-as-inappropriate').fadeToggle();
        $('#mark-as-appropriate').fadeToggle();
        $(`#cell-${cell_id}`).removeClass('appropriate');
        $(`#cell-${cell_id}`).addClass('inappropriate');
        $(`#cell-${cell_id}`).addClass('border-danger');
        $(`#cell-${cell_id}`).removeClass('border-success');
        $(`#cell-${cell_id}`).children().first().attr('data_label', 'inappropriate')
      },
      error: (error) => {
        console.log(error);
      }
    })
  })

  $('#mark-as-appropriate').on('click', (event) => {
    let cell_id = $('#nucleus-id').text();
    $.ajax({
      url: `/scanned_cells/${cell_id}?label=appropriate`,
      method: 'patch',
      success: (response) => {
        $('#mark-as-inappropriate').fadeToggle();
        $('#mark-as-appropriate').fadeToggle();
        $(`#cell-${cell_id}`).removeClass('inappropriate');
        $(`#cell-${cell_id}`).addClass('appropriate');
        $(`#cell-${cell_id}`).addClass('border-success');
        $(`#cell-${cell_id}`).removeClass('border-danger');
        $(`#cell-${cell_id}`).children().first().attr('data_label', 'appropriate')
      },
      error: (error) => {
        console.log(error);
      }
    })
  })

})
