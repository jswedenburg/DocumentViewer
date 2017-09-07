# Programming Exercise: Documents App

## Dependencies

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/) (with NPM)

## Setup

Install dependencies and run the API:
* `cd server`
* `npm install`
* `npm start`

## URL Endpoints

The api server runs by default on port 3000. It provides a data url at
`/api/documents`.

Verify now that you can see JSON data at
`http://localhost:3000/api/documents`.

## Goals

- `git checkout -b [your-name]` - a fresh branch for your work.
- Create a simple iOS app to display documents within the client folder.
- Use the screenshots from the `designs/` directory as a starting point or
  for inspiration.
- Your client application should fetch documents data from the api source.
- It should render a row for each document, showing the name and size.
- When a document's row is tapped, segue to a detail view which shows
  the PDF or image along with its name and size.
- Update the `README.md` with any instructions for running the iOS app.
- When you are done, send a zip archive over email with your changes.

### Bonus Points

- Add icons to each document row, based on the document "type" (pdf or image)
- Add search capabilities
- Simple unit tests
- Expand on the styling of the app, flexibility of the documents data, and/or
  how documents are shown to the user (be creative!)
- Make the app universal and work in all orientations

### Additional Notes

- The server purposefully adds a 500-2500 ms delay for each request.
  - You might set that to 0 for initial development (see `server/src/server.js`)
  - But in the end, find a way to show users that the file is downloading,
    such as activity indicators
- Feel free to add any libraries to the client or server apps that you'd like to
  utilize.
- Lots of freedom here, though be able to reason out why a library is useful.
  One question might be: What if you could not use said library, how could that
  be handled?
- Feel free to modify `server/src/data.json` with any changes that you see fit.
- If you do make any modifications in `server/src/`, you'll need to stop the
  process (Ctrl+C) and restart it manually (`npm start`).
