function positionArrows(element) {
    const picture = element.querySelector('.splide__slide .component__productbox-picture');
    if (!picture) return;
    const pictureRect = picture.getBoundingClientRect();
    if (pictureRect.height === 0) return;
    const sliderRect = element.getBoundingClientRect();
    const top = pictureRect.top - sliderRect.top + pictureRect.height / 2 + 1;
    element.querySelectorAll('.splide__arrow').forEach(arrow => {
        arrow.style.top = `${top}px`;
        arrow.style.transform = 'translateY(-50%)';
    });
}

function initProductSlider(element, listId) {
    let splide = new Splide(element);
    let bar = element.querySelector('.splide__progress-bar');

    splide.on('mounted move', function () {
        let end = splide.Components.Controller.getEnd() + 1;
        let rate = Math.min((splide.index + 1) / end, 1);
        bar.style.width = `${100 * rate}%`;
    });

    splide.on('mounted', function () {
        const picture = element.querySelector('.splide__slide .component__productbox-picture');
        if (!picture) return;
        const observer = new ResizeObserver(() => { positionArrows(element); });
        observer.observe(picture);
    });

    splide.mount();
}

function initAllProductSliders() {
    document.querySelectorAll('[class*="component__productslider-"][data-list-id]').forEach(element => {
        const listId = element.dataset.listId;
        initProductSlider(element, listId);
    });
}

document.addEventListener('DOMContentLoaded', initAllProductSliders);

window.initAllProductSliders = initAllProductSliders;