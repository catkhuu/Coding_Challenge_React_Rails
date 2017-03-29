'use strict'

$(function() {
  // retrieve new menu form
  $('#menu-new-btn-section').on('click', '#menu-new-btn', function(event) {
    event.preventDefault();
    hideButtons();
    var $newMenuBtn = $(this);
    var route = $newMenuBtn.attr('href');
    $.ajax({
      url: route,
      method: 'GET'
    }).done(function(response) {
      $('#menu-new-btn-section').append(response);
    })
  })

  // retrieve edit menu form
  $('.menus-index-container').on('click', '#menu-edit-btn', function(event) {
    event.preventDefault();
    alert('prevent click edit');
    var $editSelectedMenu = $(this);
    var route = $editSelectedMenu.attr('href');
    $.ajax({
      url: route,
      method: 'GET'
    }).done(function(response) {
      hideButtons();
      $('#menu-new-btn-section').append(response);
    })
  })



 // create new menu
  $('#menu-new-btn-section').on('submit', '#menu-new-form', function(event) {
    event.preventDefault();
    var $newMenuForm = $(this);
    var data = $newMenuForm.serialize();
    var route = $newMenuForm.attr('action');
    var method = $newMenuForm.attr('method');
    removeForms();

    $.ajax({
      url: route,
      type: method,
      data: data
    }).done(function(response) {

      $('tbody').prepend(response);
      showButtons();
    })
  })

  // edit menu
  $('#menu-new-btn-section').on('submit', '#menu-edit-form', function(event) {
    event.preventDefault();
    alert('disabled submit');
    var $editMenuBtn = $(this);
    var route = $editMenuBtn.attr('action');
    var menu = regEx(route);
    var data = $editMenuBtn.serialize();
    removeForms();
    showButtons();

    $.ajax({
      url: route,
      type: 'PUT',
      data: data
    }).done(function(response) {
      alert(response);
      console.log(response);
      $('tr#menu' + menu).replaceWith(response);
    })
  })

  // delete menu
  $('.menus-list').on('click', ('#menu-delete-btn'), function(event) {
    event.preventDefault();
    alert('prevent click');
    var $selectedMenu = $(this);
    var route = $selectedMenu.attr('href');
    var method = $selectedMenu.attr('data-method');

    $.ajax({
      url: route,
      type: method
    }).done(function(response) {
      $selectedMenu.closest('tr').remove();
    })
  })

  // helper functions
  function hideButtons() {
    //hide create menu button
    $('section.right-align').hide();
  }

  function showButtons() {
    $('section.right-align').show();
  }

  function removeForms() {
    $('.menu-new-container').remove();
    $('.menu-edit-container').remove();
    $($('.menus-empty-msg').parent()).remove();
  }

  function regEx(expression) {
    var myRe = /\d+/;
    var match = myRe.exec(expression);
    return match;
  }
});
