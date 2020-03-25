import { reset_buttons, render_image_card, render_rgb_nucleus, reload_image, find_channels } from './render_nucleus_lib'

$(document).on('turbolinks:load', () => {
  $("#shade").click(() => {
    $("#shade").toggle();
    $("#single-nucleus-card").fadeToggle();
  })

  $('.cell').on('click', (event) => {
    let label = $(event.target).attr('data_label');
    $('#nucleus-label').text(label)
    $('#mark-as-appropriate').hide()
    $('#mark-as-inappropriate').hide()
    if (label === 'appropriate')
      $('#mark-as-inappropriate').show()
    else
      $('#mark-as-appropriate').show()
    let cell_id = $(event.target).attr('data_value');
    $('#nucleus-id').text(cell_id)
    render_rgb_nucleus(cell_id);
  });

  $('#treated').on('click', (event) => {
    let cell_id = $(event.target).attr('data-value');
    $.ajax({
      url: `/scanned_cells/${cell_id}?treat=true`,
      success: (response) => {
        $("#channel-paths").text('')
        $("#channel-paths").text((JSON.stringify(response)));
        $("#single-nucleus").attr('src', response.treated);
        $('#original').attr('data-value', cell_id);
        $('#original').removeAttr('hidden');
        $('#treated').attr('hidden', 'hidden');
        render_image_card();
      },
      error: (error) => {
        console.log(error);
      }
    })
  });

  $('#original').on('click', (event) => {
    let cell_id = $(event.target).attr('data-value');
    render_rgb_nucleus(cell_id);
  })

  $("#blue-channel").click(() => {
    let blue = $("#blue-channel");
    if (blue.hasClass('with-blue')){
      blue.removeClass('with-blue');
      blue.removeClass('btn-primary');
      blue.addClass('btn-outline-primary');
    }else{
      blue.removeClass('btn-outline-primary');
      blue.addClass('btn-primary');
      blue.addClass('with-blue');
    }
    reload_image();
  })

  $("#red-channel").click(() => {
    let red = $("#red-channel");
    if (red.hasClass('with-red')){
      red.removeClass('with-red');
      red.removeClass('btn-danger');
      red.addClass('btn-outline-danger');
    }else{
      red.removeClass('btn-outline-danger');
      red.addClass('btn-danger');
      red.addClass('with-red');
    }
    reload_image();
  });

  $("#green-channel").click(() => {
    let green = $("#green-channel");
    if (green.hasClass('with-green')){
      green.removeClass('with-green');
      green.removeClass('btn-success');
      green.addClass('btn-outline-success');
    }else{
      green.removeClass('btn-outline-success');
      green.addClass('btn-success');
      green.addClass('with-green');
    }
    reload_image();
  });

})
