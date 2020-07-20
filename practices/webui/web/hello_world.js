cr.define('hello_world', function() {
    'use strict';
  
    /**
     * Be polite and insert translated hello world strings for the user on loading.
     */
    function initialize() {
      $('welcome-message').textContent = loadTimeData.getStringF('welcomeMessage',
          loadTimeData.getString('userName'));
      chrome.send('hello_world.addNumbers', [2, 2]);
    }

    function addResult(result) {
      alert('The result of our C++ arithmetic: 2 + 2 = ' + result);
    }
  
    // Return an object with all of the exports.
    return {
      addResult: addResult,
      initialize: initialize,
    };
  });
  
  document.addEventListener('DOMContentLoaded', hello_world.initialize);