import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import { nanoid } from 'nanoid';

const app = express();
const port = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// In-memory data
let requests = [
  { id: 'req-1', title: 'Member X asked you to take task Y', status: 'pending', createdAt: '2025-08-15T00:00:00Z' },
  { id: 'req-2', title: 'You want to take task X from member Y', status: 'pending', createdAt: '2025-08-16T00:00:00Z' },
  { id: 'req-3', title: 'Member Z accepted your request', status: 'accepted', createdAt: '2025-08-17T00:00:00Z' },
];

let notifications = [
  { id: 'not-1', title: 'Project X is overdue.', type: 'overdue', createdAt: '2025-08-12T00:00:00Z' },
  { id: 'not-2', title: 'Member Z commented on Project Y.', type: 'comment', createdAt: '2025-08-13T00:00:00Z' },
  { id: 'not-3', title: 'Member X accepted your request.', type: 'accepted', createdAt: '2025-08-14T00:00:00Z' },
];

let projects = [
  { id: 'proj-1', name: 'Project A', status: 'due_soon', tasks: 2 },
  { id: 'proj-2', name: 'Project B', status: 'on_track', tasks: 1 },
];

let projectTasks = {
  'proj-1': [
    { id: 'task-1', title: 'Design handoff', dueDate: '2025-08-18T00:00:00Z', status: 'pending', projectId: 'proj-1' },
    { id: 'task-2', title: 'Implement calendar', dueDate: '2025-08-20T00:00:00Z', status: 'blocked', projectId: 'proj-1' },
  ],
  'proj-2': [
    { id: 'task-3', title: 'QA round', dueDate: '2025-08-22T00:00:00Z', status: 'pending', projectId: 'proj-2' },
  ],
};

let calendarTasks = [
  { id: 'task-1', title: 'Project X due tomorrow', dueDate: '2025-08-17T00:00:00Z', status: 'pending', projectId: 'proj-1' },
  { id: 'task-2', title: 'Project Z kickoff', dueDate: '2025-08-19T00:00:00Z', status: 'pending', projectId: 'proj-2' },
];

// Requests
app.get('/requests', (req, res) => res.json(requests));
app.post('/requests', (req, res) => {
  const { title, dueDate } = req.body;
  if (!title) return res.status(400).json({ message: 'title is required' });
  const newReq = {
    id: `req-${nanoid(6)}`,
    title,
    status: 'pending',
    createdAt: new Date().toISOString(),
    dueDate: dueDate || null,
  };
  requests = [newReq, ...requests];
  res.status(201).json(newReq);
});
app.patch('/requests/:id', (req, res) => {
  const { id } = req.params;
  const { status } = req.body;
  const idx = requests.findIndex((r) => r.id === id);
  if (idx === -1) return res.status(404).json({ message: 'not found' });
  if (status) requests[idx].status = status;
  res.json(requests[idx]);
});

// Notifications
app.get('/notifications', (req, res) => res.json(notifications));

// Projects
app.get('/projects', (req, res) => res.json(projects));
app.get('/projects/:id/tasks', (req, res) => {
  const { id } = req.params;
  res.json(projectTasks[id] || []);
});

// Calendar
app.get('/calendar/tasks', (req, res) => res.json(calendarTasks));

app.listen(port, () => {
  console.log(`Mock backend running at http://localhost:${port}`);
});
