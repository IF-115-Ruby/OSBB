import axios from 'axios';

const token = document.querySelector('[name=csrf-token]').content
axios.defaults.headers.common['X-CSRF-TOKEN'] = token

const httpService = {
  get: (url, params) => {
    return new Promise((resolve, reject) => {
      axios(url, {
        method: 'GET',
        params: params
      }).then(res => {
          resolve(res);
      }, err => {
        reject(err);
      });
    });
  },

  post: (url, params, headers, data) => {
    return new Promise((resolve, reject) => {
      axios(url, {
        method: 'POST',
        params: params,
        headers: headers,
        data: data,
      }).then(res => {
          resolve(res);
      }, err => {
        reject(err);
      });
    });
  },

  delete: (url, params) => {
    return new Promise((resolve, reject) => {
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token
      axios(url, {
        method: 'DELETE',
        params: params
      }).then(res => {
          resolve(res);
      }, err => {
        reject(err);
      });
    });
  },
}

export default httpService;
