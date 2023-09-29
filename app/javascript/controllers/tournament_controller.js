import { Controller } from "stimulus"

export default class extends Controller {
static targets = ['btnCreate']

  connect() {
    console.log('contected');
  }

  displayTournament(event){
    
    console.log(this.btnCreateTarget)
  }
}
