/**
 * HTTP Utility Class
 * AJAX and fetch wrapper utilities following Java-style conventions
 * 
 * @author IoT Bay Development Team
 * @version 1.0.0
 */

/**
 * HTTP request options interface
 */
interface HttpRequestOptions extends RequestInit {
    headers?: HeadersInit;
}

/**
 * HTTP response interface
 */
interface HttpResponse<T = any> {
    redirected?: boolean;
    url?: string;
    data?: T;
}

/**
 * Default HTTP options
 */
interface DefaultHttpOptions {
    readonly headers: Record<string, string>;
    readonly credentials: RequestCredentials;
}

/**
 * HTTP Utility class following Java naming conventions
 * 
 * @class HttpUtil
 */
class HttpUtil {
    private static readonly DEFAULT_HEADERS: Record<string, string> = {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
    };
    
    private static readonly DEFAULT_CREDENTIALS: RequestCredentials = 'same-origin';

    /**
     * Get default options
     * 
     * @returns {DefaultHttpOptions} Default HTTP options
     * @private
     * @static
     */
    private static getDefaultOptions(): DefaultHttpOptions {
        return {
            headers: { ...HttpUtil.DEFAULT_HEADERS },
            credentials: HttpUtil.DEFAULT_CREDENTIALS
        };
    }

    /**
     * Merge headers
     * 
     * @param {Record<string, string>} defaultHeaders - Default headers
     * @param {HeadersInit | undefined} customHeaders - Custom headers
     * @returns {HeadersInit} Merged headers
     * @private
     * @static
     */
    private static mergeHeaders(
        defaultHeaders: Record<string, string>,
        customHeaders?: HeadersInit
    ): HeadersInit {
        if (!customHeaders) {
            return defaultHeaders;
        }

        if (customHeaders instanceof Headers) {
            const merged: Headers = new Headers(defaultHeaders);
            customHeaders.forEach((value: string, key: string): void => {
                merged.set(key, value);
            });
            return merged;
        }

        if (Array.isArray(customHeaders)) {
            return [...Object.entries(defaultHeaders), ...customHeaders];
        }

        return { ...defaultHeaders, ...customHeaders };
    }

    /**
     * Main request method
     * 
     * @param {string} url - Request URL
     * @param {HttpRequestOptions} options - Request options
     * @returns {Promise<HttpResponse>} Response promise
     * @private
     * @static
     */
    private static async request(
        url: string,
        options: HttpRequestOptions = {}
    ): Promise<HttpResponse> {
        const defaultOptions: DefaultHttpOptions = HttpUtil.getDefaultOptions();
        const mergedOptions: HttpRequestOptions = {
            ...defaultOptions,
            ...options,
            headers: HttpUtil.mergeHeaders(defaultOptions.headers, options.headers)
        };

        try {
            const response: Response = await fetch(url, mergedOptions);

            // Handle redirects
            if (response.redirected || response.status === 302) {
                return {
                    redirected: true,
                    url: response.url
                };
            }

            // Check if response is ok
            if (!response.ok) {
                const errorText: string = await response.text();
                throw new Error(errorText || `HTTP ${response.status}`);
            }

            // Try to parse as JSON, fallback to text
            const contentType: string | null = response.headers.get('content-type');
            if (contentType && contentType.includes('application/json')) {
                const data: any = await response.json();
                return { data };
            }

            const text: string = await response.text();
            return { data: text };
        } catch (error: any) {
            console.error('[HttpUtil] Request failed:', error);
            throw error;
        }
    }

    /**
     * GET request
     * 
     * @param {string} url - Request URL
     * @param {HttpRequestOptions} options - Request options
     * @returns {Promise<HttpResponse>} Response promise
     * @public
     * @static
     */
    public static async get(url: string, options?: HttpRequestOptions): Promise<HttpResponse> {
        return HttpUtil.request(url, {
            ...options,
            method: 'GET'
        });
    }

    /**
     * POST request
     * 
     * @param {string} url - Request URL
     * @param {any} data - Request data
     * @param {HttpRequestOptions} options - Request options
     * @returns {Promise<HttpResponse>} Response promise
     * @public
     * @static
     */
    public static async post(
        url: string,
        data?: any,
        options?: HttpRequestOptions
    ): Promise<HttpResponse> {
        return HttpUtil.request(url, {
            ...options,
            method: 'POST',
            body: JSON.stringify(data)
        });
    }

    /**
     * PUT request
     * 
     * @param {string} url - Request URL
     * @param {any} data - Request data
     * @param {HttpRequestOptions} options - Request options
     * @returns {Promise<HttpResponse>} Response promise
     * @public
     * @static
     */
    public static async put(
        url: string,
        data?: any,
        options?: HttpRequestOptions
    ): Promise<HttpResponse> {
        return HttpUtil.request(url, {
            ...options,
            method: 'PUT',
            body: JSON.stringify(data)
        });
    }

    /**
     * DELETE request
     * 
     * @param {string} url - Request URL
     * @param {HttpRequestOptions} options - Request options
     * @returns {Promise<HttpResponse>} Response promise
     * @public
     * @static
     */
    public static async delete(url: string, options?: HttpRequestOptions): Promise<HttpResponse> {
        return HttpUtil.request(url, {
            ...options,
            method: 'DELETE'
        });
    }

    /**
     * Form POST request
     * 
     * @param {string} url - Request URL
     * @param {FormData} formData - Form data
     * @param {HttpRequestOptions} options - Request options
     * @returns {Promise<HttpResponse>} Response promise
     * @public
     * @static
     */
    public static async postForm(
        url: string,
        formData: FormData,
        options?: HttpRequestOptions
    ): Promise<HttpResponse> {
        return HttpUtil.request(url, {
            ...options,
            method: 'POST',
            body: formData,
            headers: {} // Let browser set Content-Type for FormData
        });
    }
}

// Export
if (typeof module !== 'undefined' && module.exports) {
    module.exports = HttpUtil;
} else {
    (window as any).HTTP = HttpUtil;
}

