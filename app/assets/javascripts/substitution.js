function getSubstitutionForm() {
  $('#new-substitution-form').on('click', function (e) {
    e.preventDefault();
    document.getElementById("container").style.display = "block";
    document.getElementById("container").style.visibility = "visible";
    $.get("/trips/new", response => displayForm(response))
  })
}

function displayTrip(response) {
  const thisTrip = new Trip(response);
  const html = thisTrip.tripHTML();
  $('div#container').html(html);
}

function displayForm(form) {
  $("div#container").html(form);
  $("form#new_trip").on('submit', function(e) {
    e.preventDefault();
    // let formData2 = form.serialize();
    let formData = $("form#new_trip").serialize()
    console.log(formData)
    newTripSubmit(formData);
  })
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





/* class Substitution {
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
