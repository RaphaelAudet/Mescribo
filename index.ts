import {Model, IModel} from "mendixmodelsdk"

function processWorkingCopy(model: IModel, done: () => void) {
    console.log(" * Processing")

    /**
     * Your script. Invoke `done()` (asynchronously) once done.
     */
     console.log(model.allDocuments())
    //  for (var item of model.allConstants()) {
    //    console.log(item)
    //  }

     console.log("done")
    done()
}

declare var process

(function() {

    const client = Model.createSdkClient({
        credentials: {
            username: process.env.MXUSERNAME,
            apikey:   process.env.MXAPIKEY
        }
    })
    if (process.argv.length === 2) {
        // no custom arguments passed to 'npm start' (arg0 = node, arg1 = current script)
        console.log(" * Creating working copy...");
        client.createAndOpenWorkingCopy(
            {
                name: process.env.MXPROJECT_NAME,
                template: process.env.MXTEMPLATE_MPK
            },
            model => {
                console.log(` * Created working copy '${model.id}'\n * Use 'npm start ${model.id}' to re-run this script with the same working copy`)
                processWorkingCopy(
                    model,
                    () => closeWorkingCopy(model)
                )
            },
            handleError
        )
    } else {
        // custom arguments passed to 'npm start'
        const wcId = process.argv[2]
        console.log(" * Using working copy", wcId)
        client.openWorkingCopy(
            wcId,
            model => {
                processWorkingCopy(
                    model,
                    () => closeWorkingCopy(model)
                )
            },
            handleError
        )
    }

    function handleError(err) {
        console.error(err)
        process.exit(1)
    }

    // function closeWorkingCopy(client) {
    //   client.deleteWorkingCopy(() => {
    //           console.log(" * Script completed successfully")
    //           process.exit(0)
    //       })
    // }

    function closeWorkingCopy(model) {
        // flush any pending changes to the server before exiting the process
        model.closeConnection(() => {
            console.log(" * Script completed successfully")
            process.exit(0)
        })
    }
})()
