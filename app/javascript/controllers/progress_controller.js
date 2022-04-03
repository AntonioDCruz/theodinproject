import { Controller } from '@hotwired/stimulus';
import { debounce } from 'lodash';
import axios from '../src/js/axiosWithCsrf';

axios.defaults.headers.common['Content-Type'] = 'application/json';

export default class ProgressController extends Controller {
  static targets = ['percentage', 'progressCircle'];

  static values = {
    url: String,
    percent: String,
    circumference: Number,
  };

  initialize() {
    this.fetchProgress = debounce(this.fetchProgress, 400).bind(this);
  }

  connect() {
    this.fetchProgress();
  }

  disconnect() {
    console.log("disconnected")
  }

  fetchProgress() {
    axios.get(this.urlValue).then((response) => {
      const { percentage } = response.data;

      this.percentValue = percentage;
      this.percentageTarget.textContent = `${percentage}%`;
    });
  }

  percentValueChanged(percent) {
    const offset = this.circumferenceValue - percent / 100 * this.circumferenceValue;

    setTimeout(() => { this.progressCircleTarget.style.strokeDashoffset = offset }, 200)
  }
}
