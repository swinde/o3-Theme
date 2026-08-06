document.addEventListener("DOMContentLoaded", function() {
    const stars = document.querySelectorAll(".details__reviews-rating .star");
    const artratingInput = document.querySelector('input[name="artrating"]');
    const recommlistratingInput = document.querySelector('input[name="recommlistrating"]');
    let selectedRating = 0;

    // check whether both inputs exist
    const inputsExist = artratingInput && recommlistratingInput;

    stars.forEach((star, index) => {
        star.addEventListener("mouseenter", () => {
            fillStars(index + 1);
        });

        star.addEventListener("mouseleave", () => {
            fillStars(selectedRating);
        });

        star.addEventListener("click", () => {
            selectedRating = index + 1;

            // only set value when both inputs exist
            if (inputsExist) {
                artratingInput.value = selectedRating;
                recommlistratingInput.value = selectedRating;
            }

            fillStars(selectedRating);
        });
    });

    function fillStars(rating) {
        stars.forEach((star, i) => {
            if (i < rating) {
                star.classList.add("filled");
            } else {
                star.classList.remove("filled");
            }
        });
    }

    // Open and scroll to tab "Reviews" from top of page
    const openReviewsTab = document.querySelector('.component__rating');

    if (openReviewsTab) {
        openReviewsTab.addEventListener('click', function(event) {
            event.preventDefault();

            let reviewsTab = document.querySelector('.nav-tabs a[href="#details__reviews"]');
            let tabContent = document.getElementById('details__reviews');

            if (reviewsTab && tabContent) {
                new bootstrap.Tab(reviewsTab).show();
                tabContent.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            }
        });
    }

});
