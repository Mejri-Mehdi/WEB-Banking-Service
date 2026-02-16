document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.getElementById('search-input');
    const resultsContainer = document.getElementById('search-results');

    if (searchInput && resultsContainer) {
        let timeoutId;

        searchInput.addEventListener('input', function () {
            clearTimeout(timeoutId);

            const query = this.value;
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set('q', query);
            currentUrl.searchParams.set('ajax', '1');

            // Show loading state
            resultsContainer.style.opacity = '0.5';

            timeoutId = setTimeout(() => {
                fetch(currentUrl.toString(), {
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                    .then(response => response.text())
                    .then(html => {
                        resultsContainer.innerHTML = html;
                        resultsContainer.style.opacity = '1';

                        // Re-initialize any plugins if necessary (e.g., tooltips, dropdowns)
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        resultsContainer.style.opacity = '1';
                    });
            }, 300); // Debounce delay
        });
    }
});
