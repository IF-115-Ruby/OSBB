import httpService from '../../../../services/http-service';

export const getComments = async (news_id, pagestring = 1) => {
  const { data } = await httpService.get('/api/v1/news/' + news_id + '/comments?page=' + pagestring);
  return data;
}

export const createComment = async (url, news_id, headers, value) => {
  let formData = new FormData();
  formData.append('body', value);

  const params = {
    news_id: news_id,
  }

  const { data } = await httpService.post(url, params, headers, formData);
  return data;
}

export const deleteComment = async (id, parent, news_id) => {
  const params = {
    parent_comment: parent,
    news_id: news_id,
  }
  const { data } = await httpService.delete('/api/v1/comments/'+ id, params);
  return data;
};
