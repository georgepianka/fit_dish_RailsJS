class Substitution {
 constructor(obj) {
     this.id = obj.id
     this.recipeID = obj.recipe.id
     this.quantity = obj.quantity
     this.description = obj.description
     this.ingredientName = obj.ingredient.name
     this.replacedIngredientName = obj.recipe_ingredient.ingredient.name
     this.replacedIngredientQuantity = obj.recipe_ingredient.quantity
 }

 renderSubstitution() {
     return `
      <tr>
       <td><h5><i><li>${this.quantity}</i><span class="float-right ml-3"><strong><b>${this.ingredientName}</span></li></strong></b></td></h5>
       <td>
         <h6>
           <div class="center"><i class="fas fa-exchange-alt"></i></div>
           <div class="center"> &nbsp; Replacing &nbsp; </div>
         </h6>
     </td>
       <td><h5 class="replaced-ingredient"><i>${this.replacedIngredientQuantity}</i><span class="float-right ml-2"><strong><b>${this.replacedIngredientName}</span></strong></b></td></h5>
       <td>
         <h5 class="replaced-ingredient"><a class="float-right m-auto btn btn-dark border btn-sm border-muted" data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/recipes/${this.recipeID}/substitutions/${this.id}">Delete</a></h5>
       </td>
     </tr>
     <tr>
       <td colspan="4"><h6><b>Description: </b></h6>
         <h6>${this.description}</h6>
       </td>
     </tr>
     <tr><td class="bg-dark p-1" colspan="4"></td>
     </tr>
    `
 }

 static getSubstitutionForm() {
     $('#recommend-substitution').click(function (e) {
       e.preventDefault();
       const url = this.href
       console.log(url);
       $.getJSON(url, response => {
         console.log(response.form_data);
         Substitution.displaySubstitutionForm(response.form_data);
       });
     })
 }

 static displaySubstitutionForm(formData) {
     $("#new-substitution-form").html(formData);
     this.newSubstitution();
}

 static newSubstitution() {
     $("div#new-substitution-form form").on('submit', function(e) {
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

 static displayErrors(show_errors) {
     console.log(show_errors)

     const errorMessages = `<div id="error-messages" class="text-center text-danger m-2"><div class="center alert alert-danger m-3">Please Try Again!</div>${show_errors}</div>`;

     $("div#new-substitution-form").children("#error-messages").remove();
     $("div#new-substitution-form").prepend(errorMessages);
     $('form input[value="Recommend Substitution!"]').prop("disabled", false);
 }

 static updateSubstitutions(data) {
     $("div#new-substitution-form").html(`<div class="center alert alert-primary m-3">Recommended Substitution Saved!<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button></div>`);
     $("ul.list_b li:first-child").replaceWith('<table id="recipe_substitutions_table" class="table table-bordered"><tbody></tbody></table>');
     $("table#recipe_substitutions_table tbody").append(new Substitution(data).renderSubstitution());
 }

 static ready() {
     this.getSubstitutionForm()
 }

}

$(document).on('turbolinks:load', function() {
    Substitution.ready();
})
