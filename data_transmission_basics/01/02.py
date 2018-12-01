
# coding: utf-8

# In[2]:


import math
import matplotlib.pyplot as plt


# In[3]:


f = 3  # hz
O = 3 * math.pi
fs = 150  # hz
T = 2.2  # s


# In[9]:


size = int(T * fs)


# In[1]:


x = lambda n: 0.9 * math.sin(2 * math.pi * (n / fs) * math.cos(math.pi * (n / fs)) + O)


# In[5]:


y = lambda n: math.exp(-n / 25)


# In[6]:


z = lambda n: 0.001 * x(n) + 0.01 * y(n)


# In[14]:


v = lambda n: x(n) * y(n)


# In[11]:


result_z = [z(i) for i in range(size)]
result_z


# In[12]:


plt.scatter(list(range(size)), result_z)


# In[15]:


result_v = [v(i) for i in range(size)]
result_v


# In[16]:


plt.scatter(list(range(size)), result_v)

