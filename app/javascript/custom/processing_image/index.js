function marking_image(status){
  if (status === "marking_image"){
    return "Processando";
  }else if ( status === 'extracting_nucleus' || status === "processing_nucleus"){
    return "<span class='text-primary'>Concluído</span>";
  }
}

function extracting_nucleus(status){
  if (status === "extracting_nucleus"){
    return "Processando";
  } else if (status === "processing_nucleus"){
    return "<span class='text-info'>Concluído</span>";
  }else{
    return "";
  }
}

function line_builder(processing_image){
  $("#pending-images").append(`
    <tr id="${processing_image.id}-image" class="processing-image">
      <td>${processing_image.id}</td>
      <td>${processing_image.start_processing_at}</td>
      <td class="marking_image">${marking_image(processing_image.status)}</td>
      <td class="extracting_nucleus">${extracting_nucleus(processing_image.status)}</td>
    </tr>
    `).hide().fadeIn(800)
  return $(`#${processing_image.id}-image`)
}

function remove_complete_lines(updated_lines){
  let updated_ids = updated_lines.map(line => line.id );
  let keys = Object.keys(virtual_table);
  let displayed_elements = keys.map(key => virtual_table[key]);
  displayed_elements.forEach(element => {
    if (updated_ids.includes(element.id) === false){
      element.dom.fadeOut(800);
    }
  })
}

function check_lines(updated_lines){
  if($('#processing-elements').length == 0)
    clearInterval(interval)
  remove_complete_lines(updated_lines);
  updated_lines.forEach(line => {
    let keys = Object.keys(virtual_table);
    if (keys.includes(line.id.toString()) === false){
      let dom_element = line_builder(line);
      let element = {
        id: line.id,
        dom: dom_element,
        current_status: line.status
      }
      virtual_table[line.id.toString()] = element;
    } else {
      let virtual_image = virtual_table[line.id.toString()];
      if (virtual_image.current_status !== line.status) {
        if (line.status === "extracting_nucleus"){
          let previous = virtual_image.dom.children('.marking_image')
          previous.text("")
          previous.append(`<span class="text-primary">Concluído</span>`)
          let cell = virtual_image.dom.children('.extracting_nucleus')
          cell.text("Processando");
          virtual_table[line.id.toString()].current_status = line.status;
        }
      }
    }
  })
}

function reload_processing_table(){
  $.ajax({
    url: '/scanning_images?status=processing',
    dataType: 'json',
    success: (response) => {
      check_lines(response);
    },
    error: (error) => {
      console.log(error);
    }
  });
}

var virtual_table = {};
var interval = null;

$(document).on('turbolinks:load', () => {
  if ($('#processing-elements').length > 0)
    interval = setInterval(reload_processing_table, 1000);
  else
    clearInterval(interval)
});
