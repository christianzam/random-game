import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
static targets = ['btnCreate', 'playersDiv', 'addPlayerBtn', 'chevron']

  connect() {
    console.log('contected');
    console.log(this.chevronTarget);
  }

  displayGame(event){
    event.preventDefault();
    
    Rails.ajax({
      type: 'post',
      url: event.target.action,
      data: new FormData(event.target),
      success: () => {
        window.location.reload();
      },
      error: (response) => {
        console.error('error');
        console.error(response);
      }
    });
  }

  displayUserForm(){
    this.playersDivTarget.classList.toggle("hidden");
    this.chevronTarget.classList.toggle("fa-chevron-right");
    this.chevronTarget.classList.toggle("fa-chevron-down");
  }
}
