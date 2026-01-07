$(document).ready(function() {
    // Auto-close mobile menu when clicking on navigation links
    $('#mobileNav .mobile-nav-link').on('click', function() {
        const $offcanvasElement = $('#mobileNav');
        const offcanvas = bootstrap.Offcanvas.getInstance($offcanvasElement[0]);
        
        if (offcanvas) {
            offcanvas.hide();
        }
    });
});