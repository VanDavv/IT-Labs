
# coding: utf-8

# In[16]:


import math
import matplotlib.pyplot as plt


# In[2]:


f = 3  # hz
O = 3 * math.pi
fs = 150  # hz
T = 2.2  # s


# In[3]:


n = int(T * fs)


# In[12]:


x = lambda n: 0.9 * math.sin(2 * math.pi * (n / fs) * math.cos(math.pi * (n / fs)) + O)


# In[13]:


result = [x(i) for i in range(n)]
result


# In[17]:


plt.scatter(list(range(n)), result)

