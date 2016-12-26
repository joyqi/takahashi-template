
slides = []
slideEl = null
slideIndex = 0
text = '# Hello World'

render = ->
    parser = new HyperDown
    html = parser.makeHtml text
    slides = html.split '<hr>'

    if location.hash?
        index = parseInt location.hash.slice 1
        renderSlide index
    else
        renderSlide 0


renderSlide = (index) ->
    index = parseInt index
    index = 0 if not slides[index]?
    slideIndex = index

    slideEl.innerHTML = slides[index]
    #history.pushState index, '', "#{index}"


prevSlide = ->
    index = if slideIndex > 0 then slideIndex - 1 else 0
    renderSlide index


nextSlide = ->
    index = if slideIndex < slides.length - 2 then slideIndex + 1 else slides.length - 1
    renderSlide index


document.addEventListener 'DOMContentLoaded', ->
    slideEl = document.getElementById 'slide'
    scripts = document.getElementsByTagName 'script'
    
    for script in scripts
        if 'text/markdown' == script.getAttribute 'type'
            text = script.innerHTML
            break

    render()
    window.onhashchange = render
    window.onpopstate = (e) ->
        renderSlide e.state

    do resize = ->
        if window.innerWidth / window.innerHeight > 4 / 3
            slideEl.style.width = window.innerHeight * 4 / 3 + 'px'
            slideEl.style.height = window.innerHeight + 'px'
        else
            slideEl.style.width = window.innerWidth + 'px'
            slideEl.style.height = window.innerWidth * 3 / 4 + 'px'

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

