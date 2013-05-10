semver = require('semver')

module.exports = () ->
  return unless specifiedVersion = specifiedLinemanVersion()
  linemanVersion = actualLinemanVersion()
  unless semver.satisfies(linemanVersion, specifiedVersion)
    console.error """
                  Uh oh, your package.json specifies lineman version '#{specifiedVersion}', but Lineman is currently '#{linemanVersion}'.

                  Possible solutions:
                    * Try running `npm install` to install the specified lineman version locally to `node_modules/lineman`
                    * Update (or, perhaps, remove!) the version of lineman you've specified in your `package.json` and see if it works.
                  """
    process.exit(1)

specifiedLinemanVersion = ->
  packageJson = require("#{process.cwd()}/package.json")
  packageJson?.dependencies?.lineman || packageJson?.devDependencies?.lineman

actualLinemanVersion = ->
  if process.env["LINEMAN_MAIN"] == "lineman"
    require("#{process.cwd()}/node_modules/lineman/package").version
  else
    require(process.env["LINEMAN_MAIN"]).version


