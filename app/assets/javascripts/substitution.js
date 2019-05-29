function getSubstitutionForm() {
  $('#recommend-substitution').click(function (e) {
    e.preventDefault();
    const url = this.href
    console.log(url);
    $.getJSON(url, response => {
      console.log(response.form_data);
      displayForm(response.form_data);
    });
  })
}

function displayForm(form) {
  $("#new-substitution-form").html(form);

}


$(document).on('turbolinks:load', function() {
  getSubstitutionForm();
})

/*


function displayTrip(response) {
  const thisTrip = new Trip(response);
  const html = thisTrip.tripHTML();
  $('div#container').html(html);
}



function newTripSubmit(formData) {
  $.ajax({
     url: "/trips",
     type: 'POST',
     data: formData,
     dataType: 'json',
     success: (data) => updatePage(data),
     error: (xhr) => newForm(xhr)
  });
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
