from django.shortcuts import render

def index(request):
    context = {
        'nadpis': 'Web akcí',
    }

    return render(request, 'index.html', context=context)
