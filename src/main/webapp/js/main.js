/**
 * IoT Bay global frontend helpers.
 * Placeholder bundle to avoid 404s until the actual JS build is wired in.
 */
(function () {
  'use strict';

  const body = document.body;
  if (!body) {
    return;
  }

  // Basic focus-visible polyfill hook
  document.addEventListener(
    'keydown',
    function handleFirstTab(event) {
      if (event.key === 'Tab') {
        body.classList.add('using-keyboard');
        document.removeEventListener('keydown', handleFirstTab);
        document.addEventListener('mousedown', handleMouseDownOnce);
      }
    }
  );

  function handleMouseDownOnce() {
    body.classList.remove('using-keyboard');
    document.removeEventListener('mousedown', handleMouseDownOnce);
    document.addEventListener(
      'keydown',
      function handleFirstTab(event) {
        if (event.key === 'Tab') {
          body.classList.add('using-keyboard');
          document.removeEventListener('keydown', handleFirstTab);
          document.addEventListener('mousedown', handleMouseDownOnce);
        }
      }
    );
  }

  console.debug('main.js loaded');
})();

