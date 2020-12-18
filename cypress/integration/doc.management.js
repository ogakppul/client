const config = require("../../config.js");
const helpers = require("../../src/shared/doc-helpers.js");


Cypress.LocalStorage.clear = function (keys, ls, rs) {
  return;
}


describe('Managing Documents', () => {
  const testEmail = `cypress.${Date.now()}@testing.com`
  const testUserDb = 'userdb-' + helpers.toHex(testEmail);

  before(() => {
    cy.deleteUser(testEmail)
    cy.signup_blank(testEmail)

    cy.task('db:seed',{dbName: testUserDb, seedName: 'sevenTrees'})

    cy.login(testEmail)
  })

  beforeEach(() => {
    cy.fixture('sevenTrees.ids.json').as('treeIds')
    Cypress.Cookies.preserveOnce('AuthSession')
  })

  describe('Navigation', function () {
    it('Should navigate to last edited tree', function () {
      cy.visit(config.TEST_SERVER)

      cy.url().should('contain', this.treeIds[6] )

      cy.get('#file-button', {timeout: 20000}).click()

      cy.get('#sidebar-menu .sidebar-document-item', {timeout: 0})
        .should('have.length', 7)


      cy.get('#title').contains('Random letters')

    })

    it('Should navigate correctly using sidebar', function () {
      cy.visit(config.TEST_SERVER + '/' + this.treeIds[1]);

      cy.url().should('contain', this.treeIds[5] )

      // Open sidebar
      cy.get('#file-button', {timeout: 20000}).click()

      cy.contains('#sidebar-menu', 'welcome')
        .contains('#sidebar-menu', 'timeline 2021')

      // Go to Welcome doc
      cy.get('#sidebar-menu').contains('welcome').click()

      // Check Welcome doc contents
      cy.contains('#document', 'Welcome to Gingko Writer')
        .contains('#document', 'Adding New Cards')
        .contains('#document', 'Moving Cards')

      // Got to another doc
      cy.get('#sidebar-menu').contains('Screenplay')
        .click()
    })

    it('Should have a working context menu', () => {
      // Menu opens on right click
      cy.get('#sidebar-menu .sidebar-document-item')
        .first()
        .rightclick()

      cy.contains('Delete Tree')

      // Should close context menu on clicking elsewhere
      cy.get('#sidebar-context-overlay').click()
      cy.get('#sidebar-context-menu').should('not.exist')

      // Open menu again
      cy.get('#sidebar-menu .sidebar-document-item')
        .first()
        .rightclick()

      // Click the Delete Tree
      cy.contains('Delete Tree')
        .click()

      // Document should be deleted
      cy.get('#sidebar-menu').should('not.contain', 'Untitled')

      // And menu should be gone
      cy.get('#sidebar-context-menu').should('not.exist')
    })
  })

  describe.skip('Quick Switcher', ()=>{
    it('Toggles switcher modal on "Ctrl+O"', () => {
      cy.get('#switcher-modal').should('not.exist')

      cy.shortcut('{ctrl}o')
      cy.get('#switcher-modal').should('exist')

      cy.shortcut('{ctrl}o')
      cy.get('#switcher-modal').should('not.exist')
    })

    it('It autofocuses on switcher modal input', () => {
      cy.shortcut('{ctrl}o')

      cy.get('#switcher-modal input').should('have.focus')
    })

    it('Displays list of trees in switcher', () => {
      cy.get('#switcher-modal .switcher-document-list .switcher-document-item').then($list => {
        expect($list[0].innerHTML).to.contain('Another doc, with title')
        expect($list[1].innerHTML).to.contain('Untitled')
      })
    })

    it('Filters list of trees', ()=> {
      cy.get('#switcher-modal input').type('ano')

      cy.get('#switcher-modal .switcher-document-list')
        .should('contain', 'Another doc, with title')
        .should('not.contain', 'Untitled')
    })

    it('Closes "Open" modal on "Esc"', () => {
      cy.shortcut('{esc}')
      cy.get('#switcher-modal').should('not.exist')
    })

    it('Clears search filtering after "Esc"', () => {
      cy.contains('Untitled')
    })
  })
})
