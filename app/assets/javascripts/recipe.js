$(document).on('turbolinks:load', function() {
  dynamicFields();
})


function dynamicFields() {

  $('form#recipe_form').on('click', '#remove_ingredient', function(e) {
    e.preventDefault();
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('tr').hide();
  });

  $('form#recipe_form').on('click', '#add_fields', function(e) {
    e.preventDefault();
    let time = new Date().getTime();
    let regExpForChildIndex = new RegExp($(this).data('id'), 'g');
    $('#fields').append($(this).data('fields-to-add').replace(regExpForChildIndex, time));
  });

}
