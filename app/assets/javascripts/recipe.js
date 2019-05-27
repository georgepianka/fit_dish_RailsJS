$(document).on('turbolinks:load', function() {
  dynamicFields();
})


function dynamicFields() {

  $('form#new_recipe').on('click', '#remove_ingredient', e => {
    e.preventDefault();
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('tr').hide();
  });

}
