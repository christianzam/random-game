import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
static targets = ['btnCreate', 'playersDiv', 'addPlayerBtn']

  connect() {
    console.log('contected');
    // console.log(this.playersDivTarget);
    console.log(this.addPlayerBtnTarget);
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
    console.log('>>>>>>>>>>>>>>>>>');
    this.playersDivTarget.classList.toggle("hidden");
  }
}
