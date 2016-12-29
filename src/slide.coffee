
slides = []
slideEl = null
slideIndex = 0
text = '# Hello World'

render = ->
    if location.hash?
        index = parseInt location.hash.slice 1
        renderSlide index
    else
        renderSlide 0


initSlide = ->
    slideEl = document.getElementById 'slide'
    scripts = document.getElementsByTagName 'script'
    
    for script in scripts
        if 'text/markdown' == script.getAttribute 'type'
            text = script.innerHTML
            break

    parser = new HyperDown
    html = parser.makeHtml text
    slides = html.split '<hr>'


renderSlide = (index) ->
    index = parseInt index
    index = 0 if not slides[index]?
    slideIndex = index

    slideEl.innerHTML = slides[index]
    adjustSlide()
    #history.pushState index, '', "#{index}"


prevSlide = ->
    index = if slideIndex > 0 then slideIndex - 1 else 0
    location.hash = '#' + index


nextSlide = ->
    index = if slideIndex < slides.length - 2 then slideIndex + 1 else slides.length - 1
    location.hash = '#' + index


adjustSlide = ->
    img = slideEl.querySelector 'img'
    quote = slideEl.querySelector 'blockquote'

    document.body.className = if quote? then 'reverse' else ''

    if img?
        img.onload = adjustSlideCallback
    else
        adjustSlideCallback()


adjustSlideCallback = ->
    height = 0
    firstEl = null

    for el in slideEl.childNodes
        firstEl = el if not firstEl?
        height += el.offsetHeight

    firstEl.style.marginTop = (window.innerHeight - height) / 2 + 'px'
    document.title = "[#{slideIndex}] " + firstEl.textContent


document.addEventListener 'DOMContentLoaded', ->
    
    initSlide()
    render()
    window.onhashchange = render

    do resize = ->
        if window.innerWidth / window.innerHeight > 4 / 3
            slideEl.style.width = window.innerHeight * 4 / 3 + 'px'
            slideEl.style.height = window.innerHeight + 'px'
        else
            slideEl.style.width = window.innerWidth + 'px'
            slideEl.style.height = window.innerWidth * 3 / 4 + 'px'

        adjustSlide()

    window.addEventListener 'resize', resize

    window.onkeydown = (e) ->
        if e.key?
            if e.key is 'ArrowLeft'
                prevSlide()
            else if e.key is 'ArrowRight'
                nextSlide()
        else if e.keyIdentifier
            if e.keyIdentifier is 'Left'
                prevSlide()
            else if e.keyIdentifier is 'Right'
                nextSlide()

