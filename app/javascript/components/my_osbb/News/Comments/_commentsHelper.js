export function formatReply(length, vis) {
  const visibility = vis ? 'Hide' : 'Show';
  return length === 1 ? `${visibility} ${length} reply...` : `${visibility} ${length} replies...`
}
