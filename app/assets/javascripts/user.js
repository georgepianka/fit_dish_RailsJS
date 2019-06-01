$(document).on('turbolinks:load', function() {
  toggleIngredientSubstitutions();
})


function toggleIngredientSubstitutions() {

  $("a#toggle-ingredient-substitutions").click( function(e) {
    e.preventDefault();
    $(this).html(
      $(this).html() == '<span><i class="fas fa-plus"></i> &nbsp; Show Recommended Ingredient Substitutions</span>' ? '<span><i class="fas fa-minus"></i> &nbsp; Hide Recommended Ingredient Substitutions</span>' : '<span><i class="fas fa-plus"></i> &nbsp; Show Recommended Ingredient Substitutions</span>'
    )
    $('div#user-ingredient-substitutions').toggle();
  });
}
