/**
 * HTTP Utility Functions
 * AJAX and fetch wrapper utilities
 */

const HTTP = {
    /**
     * Default fetch options
     */
    defaultOptions: {
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        credentials: 'same-origin'
    },

    /**
     * GET request
     */
    get: function(url, options) {
        return this.request(url, {
            ...options,
            method: 'GET'
        });
    },

    /**
     * POST request
     */
    post: function(url, data, options) {
        return this.request(url, {
            ...options,
            method: 'POST',
            body: JSON.stringify(data)
        });
    },

    /**
     * PUT request
     */
    put: function(url, data, options) {
        return this.request(url, {
            ...options,
            method: 'PUT',
            body: JSON.stringify(data)
        });
    },

    /**
     * DELETE request
     */
    delete: function(url, options) {
        return this.request(url, {
            ...options,
            method: 'DELETE'
        });
    },

    /**
     * Form POST request
     */
    postForm: function(url, formData, options) {
        return this.request(url, {
            ...options,
            method: 'POST',
            body: formData,
            headers: {} // Let browser set Content-Type for FormData
        });
    },

    /**
     * Main request method
     */
    request: function(url, options) {
        options = { ...this.defaultOptions, ...options };
        
        // Merge headers
        if (options.headers) {
            options.headers = { ...this.defaultOptions.headers, ...options.headers };
        }

        return fetch(url, options)
            .then(response => {
                // Handle redirects
                if (response.redirected || response.status === 302) {
                    return { redirected: true, url: response.url };
                }

                // Check if response is ok
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(text || `HTTP ${response.status}`);
                    });
                }

                // Try to parse as JSON, fallback to text
                const contentType = response.headers.get('content-type');
                if (contentType && contentType.includes('application/json')) {
                    return response.json();
                }
                return response.text();
            })
            .catch(error => {
                console.error('[HTTP] Request failed:', error);
                throw error;
            });
    }
};

// Export
if (typeof module !== 'undefined' && module.exports) {
    module.exports = HTTP;
} else {
    window.HTTP = HTTP;
}






