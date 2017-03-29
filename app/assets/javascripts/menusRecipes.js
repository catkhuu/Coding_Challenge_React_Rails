'use strict'

$(document).ready(function() {
  //initialize dropdown menu to add recipe to menu
  $('select').material_select();

 // retrieve new recipe form
  $('.container').on('click', '#recipe-new-btn', function(event) {
    event.preventDefault();
    var $createRecipeBtn = $(this);
    var route = $(this).attr('href');
    hideForms();

    $.ajax({
      url: route,
      type: 'GET'
    }).done(function(response) {
      $('.container').append(response);
    })
  })

  // submit new recipe form
  $('.container').on('submit', 'div#recipe-new-submit-btn', function(event) {
    event.preventDefault();
    alert('disabled click new recipe');
  })

  // helper functions

  function initializeForm() {
    $('#textarea1').val('New Text');
    $('#textarea1').trigger('autoresize');
    $('input#input_text, textarea#textarea1').characterCounter();
  }

  function hideForms() {
    $('.menu-recipe').hide();
    $('#recipe-new-btn').hide();
  }

  function showForms() {
    $('.menu-recipe').show();
    $('#recipe-new-btn').show();
  }

 });
