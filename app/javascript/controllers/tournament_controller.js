import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const createBtn = document.getElementById('create-tournament-btn');
    console.log(createBtn);
    console.log('>>>>>>>>>>>>>');
  }

  displayPlease(){
    console.log('please please please');
  }
}
