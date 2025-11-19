// Enhanced Search Autocomplete (UI_UXdoc.md Section 4.1, 6.1)
// Provides smart search with autocomplete suggestions and keyboard navigation

(function() {
    'use strict';
    
    const searchInput = document.getElementById('searchInput');
    const searchForm = document.getElementById('searchForm');
    const searchSuggestions = document.getElementById('searchSuggestions');
    const searchClear = document.getElementById('searchClear');
    const suggestionsList = searchSuggestions?.querySelector('.nav__search-suggestions-list');
    
    if (!searchInput || !searchSuggestions || !suggestionsList) return;
    
    let currentSuggestionIndex = -1;
    let suggestions = [];
    let debounceTimer;
    
    // Sample suggestions (in production, fetch from API)
    const sampleSuggestions = [
        { text: 'LoRaWAN Temperature Sensor', category: 'Sensors', icon: 'sensor' },
        { text: 'WiFi Gateway', category: 'Gateways', icon: 'gateway' },
        { text: 'Smart Home Hub', category: 'Smart Home', icon: 'hub' },
        { text: 'Industrial IoT Controller', category: 'Controllers', icon: 'controller' },
        { text: 'Zigbee Light Switch', category: 'Smart Home', icon: 'switch' },
        { text: 'Bluetooth Beacon', category: 'Beacons', icon: 'beacon' },
        { text: 'RFID Reader', category: 'Readers', icon: 'reader' },
        { text: 'Motion Sensor', category: 'Sensors', icon: 'sensor' }
    ];
    
    // Initialize search functionality
    function initSearch() {
        // Input event with debounce
        searchInput.addEventListener('input', handleInput);
        
        // Focus event
        searchInput.addEventListener('focus', handleFocus);
        
        // Blur event (with delay to allow click on suggestions)
        searchInput.addEventListener('blur', () => {
            setTimeout(() => {
                if (!searchSuggestions.matches(':hover') && !searchInput.matches(':focus')) {
                    hideSuggestions();
                }
            }, 200);
        });
        
        // Keyboard navigation
        searchInput.addEventListener('keydown', handleKeyDown);
        
        // Clear button
        if (searchClear) {
            searchClear.addEventListener('click', handleClear);
        }
        
        // Form submission
        searchForm.addEventListener('submit', handleSubmit);
        
        // Click outside to close
        document.addEventListener('click', (e) => {
            if (!searchInput.closest('.nav__search')?.contains(e.target)) {
                hideSuggestions();
            }
        });
    }
    
    // Handle input with debounce
    function handleInput(e) {
        const query = e.target.value.trim();
        
        // Show/hide clear button
        if (searchClear) {
            searchClear.style.display = query ? 'flex' : 'none';
        }
        
        // Clear previous timer
        clearTimeout(debounceTimer);
        
        if (query.length < 2) {
            hideSuggestions();
            return;
        }
        
        // Debounce API call
        debounceTimer = setTimeout(() => {
            fetchSuggestions(query);
        }, 300);
    }
    
    // Handle focus
    function handleFocus() {
        const query = searchInput.value.trim();
        if (query.length >= 2 && suggestions.length > 0) {
            showSuggestions();
        }
    }
    
    // Handle keyboard navigation
    function handleKeyDown(e) {
        switch(e.key) {
            case 'ArrowDown':
                e.preventDefault();
                navigateSuggestions(1);
                break;
            case 'ArrowUp':
                e.preventDefault();
                navigateSuggestions(-1);
                break;
            case 'Enter':
                if (currentSuggestionIndex >= 0 && suggestions[currentSuggestionIndex]) {
                    e.preventDefault();
                    selectSuggestion(suggestions[currentSuggestionIndex]);
                }
                // Otherwise, let form submit normally
                break;
            case 'Escape':
                e.preventDefault();
                hideSuggestions();
                searchInput.blur();
                break;
        }
    }
    
    // Navigate suggestions with arrow keys
    function navigateSuggestions(direction) {
        if (suggestions.length === 0) return;
        
        // Remove previous selection
        if (currentSuggestionIndex >= 0) {
            const prevItem = suggestionsList.children[currentSuggestionIndex];
            if (prevItem) {
                prevItem.setAttribute('aria-selected', 'false');
                prevItem.classList.remove('nav__search-suggestions-item--selected');
            }
        }
        
        // Calculate new index
        currentSuggestionIndex += direction;
        
        if (currentSuggestionIndex < 0) {
            currentSuggestionIndex = suggestions.length - 1;
        } else if (currentSuggestionIndex >= suggestions.length) {
            currentSuggestionIndex = 0;
        }
        
        // Set new selection
        const currentItem = suggestionsList.children[currentSuggestionIndex];
        if (currentItem) {
            currentItem.setAttribute('aria-selected', 'true');
            currentItem.classList.add('nav__search-suggestions-item--selected');
            currentItem.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
        }
        
        // Update input value
        if (suggestions[currentSuggestionIndex]) {
            searchInput.value = suggestions[currentSuggestionIndex].text;
        }
    }
    
    // Fetch suggestions (mock - replace with actual API call)
    function fetchSuggestions(query) {
        // In production, make API call: /api/v1/products/search?q=query
        const filtered = sampleSuggestions.filter(item => 
            item.text.toLowerCase().includes(query.toLowerCase()) ||
            item.category.toLowerCase().includes(query.toLowerCase())
        );
        
        suggestions = filtered.slice(0, 8); // Limit to 8 suggestions
        renderSuggestions();
        
        if (suggestions.length > 0) {
            showSuggestions();
        } else {
            hideSuggestions();
        }
    }
    
    // Render suggestions
    function renderSuggestions() {
        suggestionsList.innerHTML = '';
        currentSuggestionIndex = -1;
        
        if (suggestions.length === 0) {
            const noResults = document.createElement('li');
            noResults.className = 'nav__search-suggestions-item';
            noResults.innerHTML = `
                <span class="nav__search-suggestions-text">No suggestions found</span>
            `;
            suggestionsList.appendChild(noResults);
            return;
        }
        
        suggestions.forEach((suggestion, index) => {
            const item = document.createElement('li');
            item.className = 'nav__search-suggestions-item';
            item.setAttribute('role', 'option');
            item.setAttribute('aria-selected', 'false');
            item.setAttribute('id', `suggestion-${index}`);
            item.setAttribute('tabindex', '-1');
            
            item.innerHTML = `
                <svg class="nav__search-suggestions-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                </svg>
                <div class="nav__search-suggestions-text">
                    <div style="font-weight: 500;">${highlightMatch(suggestion.text, searchInput.value)}</div>
                    <div style="font-size: 0.75rem; color: var(--neutral-500); margin-top: 2px;">${suggestion.category}</div>
                </div>
            `;
            
            item.addEventListener('click', () => selectSuggestion(suggestion));
            item.addEventListener('mouseenter', () => {
                // Update current index on hover
                currentSuggestionIndex = index;
                suggestions.forEach((_, i) => {
                    const listItem = suggestionsList.children[i];
                    if (listItem) {
                        listItem.setAttribute('aria-selected', i === index ? 'true' : 'false');
                        listItem.classList.toggle('nav__search-suggestions-item--selected', i === index);
                    }
                });
            });
            
            suggestionsList.appendChild(item);
        });
    }
    
    // Highlight matching text
    function highlightMatch(text, query) {
        if (!query) return text;
        const regex = new RegExp(`(${query})`, 'gi');
        return text.replace(regex, '<mark style="background-color: rgba(10, 149, 255, 0.2); padding: 0 2px; border-radius: 2px;">$1</mark>');
    }
    
    // Select a suggestion
    function selectSuggestion(suggestion) {
        searchInput.value = suggestion.text;
        hideSuggestions();
        searchForm.submit();
    }
    
    // Show suggestions
    function showSuggestions() {
        searchSuggestions.setAttribute('aria-hidden', 'false');
        searchInput.setAttribute('aria-expanded', 'true');
    }
    
    // Hide suggestions
    function hideSuggestions() {
        searchSuggestions.setAttribute('aria-hidden', 'true');
        searchInput.setAttribute('aria-expanded', 'false');
        currentSuggestionIndex = -1;
    }
    
    // Handle clear button
    function handleClear() {
        searchInput.value = '';
        searchInput.focus();
        hideSuggestions();
        if (searchClear) {
            searchClear.style.display = 'none';
        }
    }
    
    // Handle form submission
    function handleSubmit(e) {
        const query = searchInput.value.trim();
        if (!query) {
            e.preventDefault();
            return;
        }
        hideSuggestions();
    }
    
    // Initialize on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initSearch);
    } else {
        initSearch();
    }
})();

