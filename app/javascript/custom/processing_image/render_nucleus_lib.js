function reset_buttons(){
  let blue = $("#blue-channel");
  if (blue.hasClass('with-blue') === false){
    blue.addClass('with-blue');
    blue.addClass('btn-primary');
    blue.removeClass('btn-outline-primary');
  }
  let green = $("#green-channel");
  if (green.hasClass('with-green') === false){
    green.addClass('with-green');
    green.addClass('btn-success');
    green.removeClass('btn-outline-success');
  }
  let red = $("#red-channel");
  if (red.hasClass('with-red') === false){
    red.addClass('with-red');
    red.addClass('btn-danger');
    red.removeClass('btn-outline-danger');
  }
}

function render_image_card(){
  reset_buttons();
  let image_card = $("#single-nucleus-card");
  image_card.css("position", "absolute");
  image_card.css("z-index", "3");
  image_card.css("margin-top", "8%");
  image_card.css("top", $(window).scrollTop());
  image_card.fadeIn(800);
  $("#shade").css('bottom', -1 * $(document).height())
  $('#shade').show();
}

function render_rgb_nucleus(cell_id){
  $.ajax({
    url: `/scanned_cells/${cell_id}`,
    success: (response) => {
      $("#channel-paths").text('')
      $("#channel-paths").text((JSON.stringify(response)));
      $("#single-nucleus").attr('src', response.rgb);
      $("#treated").attr('data-value', cell_id);
      $('#original').attr('hidden', 'hidden');
      $('#treated').removeAttr('hidden');
      render_image_card();
    },
    error: (error) => {
      console.log(error);
    }
  })
}

function reload_image(){
  const image_paths = JSON.parse($("#channel-paths").text());
  let channels = find_channels();
  let nucleus_image = $('#single-nucleus');
  if (channels["blue"] && channels["green"] && channels["red"]){
    if (image_paths.rgb)
      nucleus_image.attr('src', image_paths.rgb);
    else
      nucleus_image.attr('src', image_paths.treated);
  } else if (channels["blue"]){
    if (channels["red"])
      nucleus_image.attr('src', image_paths.blue_red);
    else if (channels["green"])
      nucleus_image.attr('src', image_paths.blue_green);
    else
      nucleus_image.attr('src', image_paths.blue);
  } else if (channels["red"]){
    if (channels["green"])
      nucleus_image.attr('src', image_paths.green_red);
    else
      nucleus_image.attr('src', image_paths.red);
  } else
    nucleus_image.attr('src', image_paths.green);
}

function find_channels(){
  let blue = $("#blue-channel").hasClass('with-blue');
  let green = $("#green-channel").hasClass('with-green');
  let red = $("#red-channel").hasClass('with-red');
  return { "blue": blue, "green": green, "red": red };
}

export { reset_buttons, render_image_card, render_rgb_nucleus, reload_image, find_channels }
