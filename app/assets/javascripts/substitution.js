class Substitution {

 constructor(obj) {
 }
}


  Substitution.getSubstitutionForm = () => {
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

  Substitution.displaySubstitutionForm = formData => {
    Substitution.formHTML = formData;
    $("#new-substitution-form").html(formData);
    Substitution.newSubstitution();
  }

  Substitution.newSubstitution = () => {
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

  Substitution.updateSubstitutions = data => {
    $("div#new-substitution-form").html(JSON.stringify(data));
    console.log(data)
  }

  Substitution.displayErrors = show_errors => {
    console.log(show_errors)
    const errorMessages = `<div id="error-messages" class="text-center text-danger m-2"> <h4>Please Try Again!</h4> ${show_errors} </div>`;
    $("div#new-substitution-form").children("#error-messages").empty();
    $("div#new-substitution-form").prepend(errorMessages);
    $('form input[value="Recommend Substitution!"]').prop("disabled", false);

  }


  Substitution.ready = function() {
    this.getSubstitutionForm()
  }


$(document).on('turbolinks:load', function() {
  Substitution.ready();
})

/*


function displayTrip(response) {
  const thisTrip = new Trip(response);
  const html = thisTrip.tripHTML();
  $('div#container').html(html);
}





function newForm(response){
  console.log(response.responseJSON.error)
  let errors = response.responseJSON.error
  for (const message of errors) {
    $("div#container").prepend(`<p> ${message} </p>`)
  }
}





 class Substitution {
  constructor(obj) {
    this.

  }
}








Substitution.ready = function() {
  this.getSubstitutions()
  this.getSubstitutionForm()
}



$(document).on('turbolinks:load', function() {
  Substitution.ready();
})

*/
