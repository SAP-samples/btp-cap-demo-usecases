const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {
  
  const { Incidents, Comments, Priorities, Statuses } = this.entities;

  // Validation before creating/updating incidents
  this.before(['CREATE', 'UPDATE'], 'Incidents', async (req) => {
    const { title, priority_ID, status_ID } = req.data;
    
    // Validate required fields
    if (!title || title.trim().length === 0) {
      req.error(400, 'Title is required and cannot be empty');
    }
    
    if (title && title.length > 100) {
      req.error(400, 'Title cannot exceed 100 characters');
    }
    
    // Validate priority exists
    if (priority_ID) {
      const priority = await SELECT.one.from(Priorities).where({ ID: priority_ID });
      if (!priority) {
        req.error(400, 'Invalid priority selected');
      }
    }
    
    // Validate status exists
    if (status_ID) {
      const status = await SELECT.one.from(Statuses).where({ ID: status_ID });
      if (!status) {
        req.error(400, 'Invalid status selected');
      }
    }
  });

  // Validation before creating/updating comments
  this.before(['CREATE', 'UPDATE'], 'Comments', async (req) => {
    const { text, incident_ID } = req.data;
    
    // Validate required fields
    if (!text || text.trim().length === 0) {
      req.error(400, 'Comment text is required and cannot be empty');
    }
    
    if (text && text.length > 1000) {
      req.error(400, 'Comment text cannot exceed 1000 characters');
    }
    
    // Validate incident exists
    if (incident_ID) {
      const incident = await SELECT.one.from(Incidents).where({ ID: incident_ID });
      if (!incident) {
        req.error(400, 'Invalid incident reference');
      }
    }
  });

  // Set default status to 'OPEN' for new incidents if not provided
  this.before('CREATE', 'Incidents', async (req) => {
    if (!req.data.status_ID) {
      const openStatus = await SELECT.one.from(Statuses).where({ code: 'OPEN' });
      if (openStatus) {
        req.data.status_ID = openStatus.ID;
      }
    }
  });

  // Log incident status changes
  this.after('UPDATE', 'Incidents', async (data, req) => {
    if (req.data.status_ID) {
      const incident = await SELECT.one.from(Incidents).where({ ID: data.ID });
      const status = await SELECT.one.from(Statuses).where({ ID: req.data.status_ID });
      console.log(`Incident ${incident.title} status changed to ${status.name}`);
    }
  });

});
