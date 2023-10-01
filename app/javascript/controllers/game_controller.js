import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
static targets = ['btnCreate']

  connect() {
    console.log('contected');
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
}
