import { useState } from 'react';

export default function Home() {
  const [name, setName] = useState('');
  const [url, setUrl] = useState('');
  const [status, setStatus] = useState<string | null>(null);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setStatus(null);
    const res = await fetch('/api/submit', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name, url }),
    });
    const data = await res.json();
    if (data.error) {
      setStatus(data.error);
    } else {
      setStatus('Submitted!');
      setName('');
      setUrl('');
    }
  }

  return (
    <main style={{ padding: '2rem' }}>
      <h1>Submit Evaluation</h1>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Name </label>
          <input value={name} onChange={e => setName(e.target.value)} required />
        </div>
        <div>
          <label>Patch URL </label>
          <input value={url} onChange={e => setUrl(e.target.value)} required />
        </div>
        <button type="submit">Submit</button>
      </form>
      {status && <p>{status}</p>}
    </main>
  );
}
