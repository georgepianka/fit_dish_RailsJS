



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

function toggleRecipeIndex() {

  $("a#toggle-dishes-recipe-index").click( function(e) {
    e.preventDefault();
    $(this).html(
      $(this).html() == '<span><i class="fas fa-list"></i> &nbsp; Show All Recipes</span>' ? '<span><i class="far fa-minus-square"></i> &nbsp; Hide All Recipes</span>' : '<span><i class="fas fa-list"></i> &nbsp; Show All Recipes</span>'
    )
    $('div#dishes-recipe-index').toggle();
  });
}



$(document).on('turbolinks:load', function() {
  dynamicFields();
  toggleRecipeIndex();
})
