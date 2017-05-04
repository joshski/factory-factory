Feature: Creating a factory

  Scenario: Generating a factory from the command line
    Given the file "adapters/app/app.js" contains:
      """
      class App {
        constructor({ db }) {
          this.db = db
        }
      }

      module.exports = App
      """
    And the file "adapters/db/memory.js" contains:
      """
      class MemoryDb {
        constructor({ logger }) {
          this.logger = logger
        }
      }

      module.exports = MemoryDb
      """
    And the file "adapters/db/postgres.js" contains:
      """
      class PostgresDb {
        constructor({ logger }) {
          this.logger = logger
        }
      }

      module.exports = PostgresDb
      """
    And the file "adapters/logger/console.js" contains:
      """
      class ConsoleLogger {}

      module.exports = ConsoleLogger
      """
    And the file "adapters/logger/file.js" contains:
      """
      class FileLogger {}

      module.exports = FileLogger
      """
    And the file "production.js" contains:
      """
      const factory = require('./factory')

      console.log(factory('app', { db: 'postgres', logger: 'file' }))
      """
    When I run `factory-factory adapters/*/*.js`
    And I run `node production.js`
    Then the output should be:
      """
      App { db: PostgresDb { logger: FileLogger {} } }
      """
  
