#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */
process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val greeting

    output:
        path "${greeting}-output.txt"

    script:
    """
    echo '$greeting' > $greeting-output.txt
    """
}

/*
 * Pipeline parameters
 */
params.greeting = 'greetings.csv'

workflow {

    // declare an array of input greetings
    greetings_array = ['Hello', 'Bonjour', 'Hola']

    // create a channel for inputs
    greetings_ch = Channel.fromPath(params.greeting)
        .splitCsv()
        .map { item -> item[0] }

    // emit a greeting
    sayHello(greetings_ch)
}
