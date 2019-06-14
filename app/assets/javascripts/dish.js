/*
class Dish {
  constructor(obj) {

  }

  static addToDishes() {
      $("div#dishes-recipe-index").on('click', "li.recipe-index-item a.add-recipe-to-dishes", function(e) {
        e.preventDefault();
        let formData = $(this).serialize();
        console.log(this.attributes.action.value)
        let action = this.attributes.action.value

        $.ajax({
           url: action,
           type: 'POST',
           data: formData,
           dataType: 'json',
           success: (data) => Substitution.updateSubstitutions(data),
           error: (xhr) => Substitution.displayErrors(xhr.responseJSON.show_errors)
        });
      });
  }





  static ready() {
      this.addToDishes;
  }

}


$(document).on('turbolinks:load', function() {
  Dish.ready();
})
*/
